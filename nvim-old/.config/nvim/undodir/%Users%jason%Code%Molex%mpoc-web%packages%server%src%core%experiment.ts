Vim�UnDo� ��T���0|T�v��Y�7pCi(�7e:�N
�:                                     b��D     _�                              ����                                                                                                                                                                                                                                                                                                                                                             b��C     �                 import {     CreateExperimentInput,     ExperimentParameter,   !  CreateExperimentParameterInput,     ExperimentParameterValue,   &  CreateExperimentParameterValueInput,     ExperimentRun,     CreateExperimentRunInput,     UpdateExperimentRunInput,     ExperimentState,     Experiment,     UpdateExperimentInput,   } from 'boundary/experiment';    import { config } from 'config';   import { Knex } from 'knex';   #import { get, omit } from 'lodash';   6import { parseJsonFile, unzipFile } from 'utils/file';   'import { doRequest } from 'utils/http';   $import { v4 as uuidv4 } from 'uuid';       (export async function createExperiment({     experimentInput,     trx,   }: {   )  experimentInput: CreateExperimentInput;     trx: Knex.Transaction;   }): Promise<string> {      const experimentId = uuidv4();   M  const runFileName = experimentInput.runFileUrl.split('/')[4].split('.')[0];   `  const runFileExtension = experimentInput.runFileUrl.split('/')[4].split('.')[1].split('?')[0];   U  const parametersInsterted = await getExperimentPameters({ fileName: runFileName });     const experimentToInsert = {       id: experimentId,       name: experimentInput.name,   %    version: experimentInput.version,   3    functionName: parametersInsterted.functionName,       archiveName: runFileName,   P    runFileUrl: `${config.aws.s3.bucketUrl}/${runFileName}.${runFileExtension}`,     };       0  if (!parametersInsterted.parameters?.length) {   *    throw new Error('Missing parameters');     }       6  await trx('experiments').insert(experimentToInsert);       f  await createExperimentParameters({ experimentId, parameters: parametersInsterted.parameters, trx });       V  if (experimentInput.supportFileUrls && experimentInput.supportFileUrls.length > 0) {   U    const supportFileUrls = experimentInput.supportFileUrls.map((supportFileUrl) => {   I      const supportFileName = supportFileUrl.split('/')[4].split('.')[0];   ]      const supportFileExstension = supportFileUrl.split('/')[4].split('.')[1].split('?')[0];       V      return `${config.aws.s3.bucketUrl}/${supportFileName}.${supportFileExstension}`;       });   R    await createExperimentSupportFileUrls({ experimentId, supportFileUrls, trx });     }         return experimentId;   }       3export async function createExperimentFromZipFile({     experimentInput,     zipFileName,     trx,   }: {   )  experimentInput: CreateExperimentInput;     zipFileName: string;     trx: Knex.Transaction;   }) {     try {   0    const experimentName = experimentInput.name;   ?    await unzipFile({ zipFileName, fileName: experimentName });   8    const filePath = `${zipFileName}/${experimentName}`;   A    const parameterJson: any = await parseJsonFile({ filePath });       const parameters: any = [];   B    parameterJson[experimentName].inputs.forEach((input: any) => {         parameters.push({           label: input.name,   '        type: `${input.type[0] || ''}`,           units: input.purpose,   	      });       });           const newExperiment = {   /      ...omit(experimentInput, ['parameters']),         parameters,       };       E    return createExperiment({ experimentInput: newExperiment, trx });     } catch (error) {        console.log('error', error);   7    return 'Unable to create experiment from zip file';     }   }       2export async function createExperimentParameters({     experimentId,     parameters,     trx,   }: {     experimentId: string;   /  parameters: CreateExperimentParameterInput[];     trx: Knex.Transaction;    }): Promise<string[] | string> {     try {   :    const parametersToInsert = parameters.map((param) => {   (      return { id: uuidv4(), ...param };       });       k    let insertedParameters = await trx('experiment_parameters').insert(parametersToInsert).returning('id');       <    insertedParameters = insertedParameters.map((param) => {   ?      return { experimentId, experimentParameterId: param.id };       });       \    const insertedParameterIds: string[] = await trx('experiments_to_experiment_parameters')   !      .insert(insertedParameters)   ,      .returning('experiment_parameter_id');        return insertedParameterIds;     } catch (error) {       console.log(error);   >    throw new Error('Unable to create experiment parameters');     }   }       7export async function createExperimentSupportFileUrls({     experimentId,     supportFileUrls,     trx,   }: {     experimentId: string;     supportFileUrls: string[];     trx: Knex.Transaction;    }): Promise<string[] | string> {     try {   M    const supportFileUrlsToInsert = supportFileUrls.map((supportFileUrl) => {   .      return { id: uuidv4(), supportFileUrl };       });       K    let insertedSupportFileUrls = await trx('experiment_support_file_urls')   &      .insert(supportFileUrlsToInsert)         .returning('id');       O    insertedSupportFileUrls = insertedSupportFileUrls.map((supportFileUrl) => {   M      return { experimentId, experimentSupportFileUrlId: supportFileUrl.id };       });       h    const insertedSupportFileUrlIds: string[] = await trx('experiments_to_experiment_support_file_urls')   &      .insert(insertedSupportFileUrls)   3      .returning('experiment_support_file_url_id');   %    return insertedSupportFileUrlIds;     } catch (error) {       console.log(error);   E    throw new Error('Unable to create experiment support file urls');     }   }       +export async function createExperimentRun({     experimentRunInput,     trx,   }: {   /  experimentRunInput: CreateExperimentRunInput;     trx: Knex.Transaction;   }): Promise<string> {     try {   %    let experimentRunId: string = '';       #    const experimentRunToInsert = {         id: uuidv4(),   2      experimentState: ExperimentState.PROCESSING,   F      simulationEnvironment: experimentRunInput.simulationEnvironment,       };       o    const insertedExperimentRun = await trx('experiment_runs').insert([experimentRunToInsert]).returning('id');       2    experimentRunId = insertedExperimentRun[0].id;   '    const experimentToExperimentRun = {   4      experimentId: experimentRunInput.experimentId,         experimentRunId,       };       c    await trx('experiments_to_experiment_runs').insert(experimentToExperimentRun).transacting(trx);       .    await createExperimentRunParameterValues({         experimentRunId,   :      parameterValues: experimentRunInput.parameterValues,   
      trx,       });       return experimentRunId;     } catch (error) {       console.log(error);   -    return 'Unable to create experiment run';     }   }       :export async function createExperimentRunParameterValues({     experimentRunId,     parameterValues,     trx,   }: {     experimentRunId: string;   9  parameterValues: CreateExperimentParameterValueInput[];     trx: Knex.Transaction;    }): Promise<string[] | string> {     try {   N    const parameterValuesToInsert = parameterValues.map((parameterValues) => {   2      return { id: uuidv4(), ...parameterValues };       });       R    const insertedParameterValueIds = await trx('experiment_run_parameter_values')   &      .insert(parameterValuesToInsert)         .returning('id');       R    const insertedParameterValues = insertedParameterValueIds.map((parameter) => {   N      return { experimentRunId, experimentRunParameterValueId: parameter.id };       });       U    await trx('experiment_runs_to_parameter_values').insert(insertedParameterValues);       %    return insertedParameterValueIds;     } catch (error) {       console.log(error);   C    throw new Error('Unable to create experiment paramter values');     }   }       %export async function getExperiment({     experimentId,     trx,   }: {     experimentId: string;     trx: Knex | Knex.Transaction;    }): Promise<Experiment | null> {     try {   P    return trx('experiments').whereIn('experiments.id', [experimentId]).first();     } catch (error) {       console.log(error);       return null;     }   }       (export async function getExperimentRun({     experimentRunId,     trx,   }: {     experimentRunId: string;     trx: Knex | Knex.Transaction;   #}): Promise<ExperimentRun | null> {     try {   i    return trx('experiment_runs').whereIn('experiment_runs.id', [experimentRunId]).select(['*']).first();     } catch (error) {       console.log(error);       return null;     }   }       iexport async function listExperiments({ trx }: { trx: Knex | Knex.Transaction }): Promise<Experiment[]> {     try {   J    return trx('experiments').select(['*']).orderByRaw('created_at desc');     } catch (error) {       console.log(error);       return [];     }   }       *export async function listExperimentRuns({     experimentId,     trx,   }: {   "  experimentId: string | string[];     trx: Knex | Knex.Transaction;   }): Promise<ExperimentRun[]> {     if (!experimentId?.length) {   1    throw new Error('Experiment id is required');     }       %  if (!Array.isArray(experimentId)) {   "    experimentId = [experimentId];     }       .  return trx('experiments_to_experiment_runs')   J    .whereIn('experiments_to_experiment_runs.experiment_id', experimentId)   f    .join('experiment_runs', 'experiments_to_experiment_runs.experiment_run_id', 'experiment_runs.id')       .select([   !      'experiment_runs.id as id',         'created_at',         'updated_at',         'deleted_at',         'result_data_url',         'result_viz_data_url',         'result_json_url',   !      'experimentState as state',   E      'experiments_to_experiment_runs.experiment_id as experimentId',         'simulation_environment',       ]);   }       0export async function listExperimentParameters({     experimentId,     trx,   }: {   "  experimentId: string | string[];     trx: Knex | Knex.Transaction;   $}): Promise<ExperimentParameter[]> {     try {        if (!experimentId?.length) {   3      throw new Error('Experiment id is required');       }       '    if (!Array.isArray(experimentId)) {   $      experimentId = [experimentId];       }       6    return trx('experiments_to_experiment_parameters')   R      .whereIn('experiments_to_experiment_parameters.experiment_id', experimentId)         .join(            'experiment_parameters',   G        'experiments_to_experiment_parameters.experiment_parameter_id',   "        'experiment_parameters.id'         )         .select([   (        'experiment_parameter_id as id',           'label',           'type',           'units',   M        'experiments_to_experiment_parameters.experiment_id as experimentId',   	      ]);     } catch (error) {       console.log(error);       return [];     }   }       5export async function listExperimentSupportFileUrls({     experimentId,     trx,   }: {   "  experimentId: string | string[];     trx: Knex | Knex.Transaction;   M}): Promise<{ id: string; supportFileUrl: string; experimentId: string }[]> {     try {        if (!experimentId?.length) {   3      throw new Error('Experiment id is required');       }       '    if (!Array.isArray(experimentId)) {   $      experimentId = [experimentId];       }       =    return trx('experiments_to_experiment_support_file_urls')   Y      .whereIn('experiments_to_experiment_support_file_urls.experiment_id', experimentId)         .join(   '        'experiment_support_file_urls',   U        'experiments_to_experiment_support_file_urls.experiment_support_file_url_id',   )        'experiment_support_file_urls.id'         )         .select([   /        'experiment_support_file_url_id as id',           'support_file_url',   D        'experiments_to_experiment_support_file_urls.experiment_id',   	      ]);     } catch (error) {       console.log(error);       return [];     }   }       8export async function listExperimentRunParameterValues({     experimentRunId,     trx,   }: {   %  experimentRunId: string | string[];     trx: Knex | Knex.Transaction;   )}): Promise<ExperimentParameterValue[]> {     try {   #    if (!experimentRunId?.length) {   3      throw new Error('Experiment id is required');       }       *    if (!Array.isArray(experimentRunId)) {   *      experimentRunId = [experimentRunId];       }       5    return trx('experiment_runs_to_parameter_values')   X      .whereIn('experiment_runs_to_parameter_values.experiment_run_id', experimentRunId)         .join(   *        'experiment_run_parameter_values',   P        'experiment_runs_to_parameter_values.experiment_run_parameter_value_id',   ,        'experiment_run_parameter_values.id'         )         .select([   2        'experiment_run_parameter_value_id as id',           'value',   S        'experiment_runs_to_parameter_values.experiment_run_id as experimentRunId',   7        'experiment_run_parameter_values.parameter_id',   	      ]);     } catch (error) {        console.log('error', error);       return [];     }   }       (export async function updateExperiment({     experimentId,     updateData,     trx,   }: {     experimentId: string;   $  updateData: UpdateExperimentInput;     trx: Knex.Transaction;   }): Promise<boolean> {     try {       await trx('experiments')   "      .where({ id: experimentId })   !      .update({ ...updateData });     } catch (error) {       console.log(error);       return false;     }         return true;   }       +export async function updateExperimentRun({     experimentRunId,     updateData,     trx,   }: {     experimentRunId: string;   '  updateData: UpdateExperimentRunInput;     trx: Knex.Transaction;   }): Promise<boolean> {     try {        await trx('experiment_runs')   %      .where({ id: experimentRunId })   !      .update({ ...updateData });     } catch (error) {       console.log(error);       return false;     }         return true;   }       (export async function deleteExperiment({     experimentId,     trx,   }: {     experimentId: string;     trx: Knex.Transaction;   }): Promise<boolean> {   Y  const result = await softDelete({ table: 'experiments', recordId: experimentId, trx });     return result;   }       +export async function deleteExperimentRun({     experimentRunId,     trx,   }: {     experimentRunId: string;     trx: Knex.Transaction;   }): Promise<boolean> {   `  const result = await softDelete({ table: 'experiment_runs', recordId: experimentRunId, trx });     return result;   }       async function softDelete({     table,     recordId,     trx,   }: {     table: string;     recordId: string;     trx: Knex.Transaction;   }): Promise<boolean> {     try {   ]    await trx(table).where({ id: recordId }).update({ deletedAt: new Date().toISOString() });     } catch (error) {       console.log(error);       return false;     }         return true;   }       Qexport async function getExperimentPameters({ fileName }: { fileName: string }) {     if (!fileName) {   3    throw new Error(`Unable to extract file name`);     }       '  const experiments = await doRequest({       host: config.matlab.url,       path: '/api/discovery',       method: 'GET',   F    headers: { Authorization: `bearer ${config.matlab.accessToken}` },     });       X  const experimentFunctions = get(experiments, `archives["${fileName}"].functions`, {});   >  const functionName = Object.keys(experimentFunctions).pop();       X  let parameters = get(experimentFunctions, `${functionName}.signatures[0].inputs`, []);         if (!parameters?.length) {   b    throw new Error(`Unable to find parameters from ${fileName} experiment on the discovery API`);     }       .  parameters = parameters.map((parameter) => {       return {         label: parameter.name,         type: parameter.mwtype,         units: parameter.help,       };     });   
  return {       parameters,       functionName,     };   }5�5��