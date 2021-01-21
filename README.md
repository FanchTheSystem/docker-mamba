## Docker Image with miniconda and mamba

- Example

```
docker run -it fanchthesystem/mamba /opt/conda/bin/mamba --version
```


```
docker run -it registry.gitlab.com/ifb-elixirfr/docker-images/mamba mamba --version
```

- if you have a env.yml in the current directory, you want to run something like this:

```
docker run -it -v $PWD:/tmp/test registry.gitlab.com/ifb-elixirfr/docker-images/mamba mamba env create -f /tmp/test/env.yml
```

- Purpose

Test conda env creation
