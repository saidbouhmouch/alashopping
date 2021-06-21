export enum LogLevel {
  Off = 0,
  Error,
  Warning,
  Info,
  Debug
}

/**
 * Log output handler function.
 */
export type LogOutput = (source: string | undefined, level: LogLevel, ...objects: any[]) => void;

export class Logger {
  
  static level = LogLevel.Debug;

  static outputs: LogOutput[] = [];

  constructor(private source?: string) {}

  static enableProductionMode() {
    this.level = LogLevel.Warning;
  }

  debug(...objects: any[]) {
    this.log(console.log, LogLevel.Debug, objects);
  }

  info(...objects: any[]) {
    this.log(console.info, LogLevel.Info, objects);
  }

  warn(...objects: any[]) {
    this.log(console.warn, LogLevel.Warning, objects);
  }

  error(...objects: any[]) {
    this.log(console.error, LogLevel.Error, objects);
  }

  private log(func: (...args: any[]) => void, level: LogLevel, objects: any[]) {
    if (level <= Logger.level) {
      const log = this.source ? ['[' + this.source + ']'].concat(objects) : objects;
      func.apply(console, log);
      Logger.outputs.forEach(output => output.apply(output, [this.source, level, ...objects]));
    }
  }
}
