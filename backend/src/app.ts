import fastify from 'fastify';
import cors from '@fastify/cors';
import { TypeBoxValidatorCompiler } from '@fastify/type-provider-typebox';

import config from 'plugins/config';
import prisma from 'plugins/prisma';
import jwt from 'plugins/jwt';

import userRoutes from 'modules/user/routes/user.routes';

const BASE_URL = '/api/v1';

const createApp = async () => {
  const app = fastify({
    ajv: {
      customOptions: {
        removeAdditional: 'all',
        coerceTypes: true,
        useDefaults: true,
      },
    },
    logger: {
      level: process.env.LOG_LEVEL,
    },
  });

  app.setErrorHandler((err, req, reply) => {
    reply.status(err.statusCode || 500).send({
      statusCode: err.statusCode || 500,
      message: err.message || 'Internal server error',
    });
  });

  // Plugins
  await app.register(config);
  await app.register(cors, { origin: true });
  await app.register(jwt);
  await app.register(prisma);

  // Routes
  await app.register(userRoutes, { prefix: `${BASE_URL}/users` });

  app.setValidatorCompiler(TypeBoxValidatorCompiler);

  await app.ready();

  async function start() {
    process.on('unhandledRejection', (err) => {
      console.error(err);
      process.exit(1);
    });

    const port = +app.config.API_PORT;
    const host = app.config.API_HOST;
    await app.listen({ host, port });

    for (const signal of ['SIGINT', 'SIGTERM']) {
      process.on(signal, () =>
        app.close().then((err) => {
          console.log(`close application on ${signal}`);
          process.exit(err ? 1 : 0);
        }),
      );
    }
  }

  return { app, start };
};

export default createApp;
