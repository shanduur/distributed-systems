## Requirements

- Docker Desktop with Kubernetes enabled (or a Kubernetes cluster, e.g. Minikube, Kind, K3d, etc.)
- `kubectl`

## Tasks

1. Create an application that will perform the following tasks:
    - Watch Pods in the `default` namespace.
    - When a Pod is created, updated or deleted, print its name and the event type.
2. _OPTIONALLY:_ Add the following features:
    - Watch pods in multiple namespaces (one thread per namespace).
    - Notify about the event using a Discord webhook.
