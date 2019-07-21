package main

import (
	"log"
	"os"

	"github.com/xanzy/go-gitlab"
)

func main() {
	git := gitlab.NewClient(nil, os.Getenv("GITLAB_TOKEN"))

	opt := &gitlab.ListProjectsOptions{
		ListOptions: gitlab.ListOptions{
			PerPage: 100,
			Page:    2,
		},
		Membership: gitlab.Bool(true),
		Archived:   gitlab.Bool(false),
	}
	projects, _, err := git.Projects.ListProjects(opt)
	if err != nil {
		log.Fatal(err)
	}

	for _, project := range projects {
		log.Printf("Found project: %s %s", project.Name, project.PathWithNamespace)
	}
}
