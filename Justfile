set dotenv-load := true

install-dependencies:
    poetry install

run-tpch name +ARGS="":
    poetry run python ./benchmarks/tpch-{{name}}.py {{ARGS}}

run-ddos name +ARGS="":
    poetry run python ./benchmarks/ddos-{{name}}.py {{ARGS}}
