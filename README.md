# Access Control Helm Chart

## Current version: 1.0.0.

## Installation

### Using the Helm repository hosted in GitHub Pages

First, add the Helm repository:

```bash
$ helm repo add access-control-helm https://tefiros.github.io/Access-control-helm/
```

Then, install the Helm Chart:

```bash
$ helm install access-control Access-control-helm/access-control
```

The chart will be installed using the default values. Use the provided [`values.yaml`](values.yaml) file in this repository as template to upgrade the installation with your desired parameters:

```bash
$ helm upgrade access-control -f myvalues.yaml
```

To uninstall the Helm Chart, run the following command:

```bash
$ helm uninstall access-control
```

### Cloning this repository

First, clone the repository:

```bash
$ git clone https://github.com/tefiros/access-control-helm.git
```

Once cloned, edit the [`values.yaml`](values.yaml) file to match your deployment needs and run the following command:

```bash
$ helm install access-control .
```

To uninstall the Helm Chart, run the following command:

```bash
$ helm uninstall access-control
```
