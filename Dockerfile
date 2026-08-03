# Stage 1: build web (Astro server / SSR)
FROM oven/bun:1 AS web-builder
WORKDIR /build
COPY web/package.json web/bun.lock* ./
RUN bun install --frozen-lockfile
COPY web/ ./
# Same-origin: API/WS on same host in production
ENV PUBLIC_API_URL=
ENV PUBLIC_WS_URL=
RUN bun run build

# Stage 2: server + web dist (no node_modules; install at runtime)
FROM oven/bun:1
WORKDIR /app
COPY server/package.json server/bun.lock* ./
RUN bun install --frozen-lockfile
COPY server/ ./
# Web dist (client + server entry) + package.json/lock so we can install deps at startup
COPY --from=web-builder /build/dist ./web-dist
COPY --from=web-builder /build/package.json /build/bun.lock* ./web-dist/

ENV PORT=3000
ENV HOST=0.0.0.0
ENV WEB_DIST_DIR=/app/web-dist

EXPOSE 3000
# Install web SSR deps in web-dist then start server (image stays smaller, no node_modules layer)
CMD ["sh", "-c", "cd /app/web-dist && bun install --frozen-lockfile --production && cd /app && exec bun run start"]
