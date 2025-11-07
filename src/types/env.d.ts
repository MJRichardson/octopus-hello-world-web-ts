declare global {
    namespace NodeJS {
        interface ProcessEnv {
            GREETING?: string;
            ENVIRONMENT?: string;
            PORT?: string;
        }
    }
}
export {};