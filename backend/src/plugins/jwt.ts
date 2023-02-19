import { FastifyPluginAsync } from 'fastify';
import fp from 'fastify-plugin';
import fastifyJwt from '@fastify/jwt';
import { User } from 'modules/user/schema/user.schema';

declare module '@fastify/jwt' {
  interface FastifyJWT {
    payload: Pick<User, 'id'>;
  }
}

const jwtPlugin: FastifyPluginAsync = fp(async (server) => {
  server.register(fastifyJwt, {
    secret: server.config.JWT_SECRET_KEY,
  });
});

export default jwtPlugin;
