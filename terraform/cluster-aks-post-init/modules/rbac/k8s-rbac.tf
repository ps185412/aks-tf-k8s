resource "kubernetes_cluster_role_binding" "rbac" {
    
    metadata {
        name = "${var.clusterrole_binding_metadata}"
    }
    role_ref {
        api_group = "rbac.authorization.k8s.io"
        kind = "ClusterRole"
        name = "cluster-admin"
    }
    subject {
        kind = "Group"
        name = "${var.azure_ad_group_id}"
        api_group = "rbac.authorization.k8s.io"
    }
}
