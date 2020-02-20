# Directory / File Structure
## topic docs
* topics serve as a catalog of available content
	* not all topics have to be used in a cohort (dependent on how it is structured)
* each topic is atomic
	* topics are easily composed into days / weeks of curriculum schedule
	* topics can be combined to create custom weeks / courses for clients besides the NGA
* topics have at minimum:
	* index: tie the topic docs together by ref and includes external reference links
	* slides: slide content for teaching the topic
	* objectives: conceptual and practical learning objectives
		* conceptual: concepts and terminology that the student should understand and be capable of discussing
		* practical: syntax and commands the student should be able to apply
* topics can also include associated docs
	* walkthrough: instructor-led practical application of the topic
	* studio: self-guided practical application of the topic
	* command / syntax reference: quick reference for commands or syntax related to the topic

### dir structure
* topics are created using the `create-topic.sh` interactive script
	* **do not create by hand** to enforce standard format and references
	* creates the topic docs and boilerplate structure
```sh
src/topics/
  topic-name/ <-- dir and docs created by script
    index.rst
    objectives.rst
    walkthrough.rst
    studio.rst
    commands.rst !! name as "reference" to cover commands and syntax? !!
    slides.md !! NOT YET SETTLED !!
```
* for extensive topics they can be split into `basic` and `advanced` using the `topic-name` as a common prefix
	* for grouping topics alphabetically
```sh
src/topics/
  topic-name-prefix-basic/
  topic-name-prefix-advanced/
```
* if an existing topic is expanded to advanced in the future
	* leave original (to not break refs)
	* create `topic-name-advanced` and add content

### ref naming
* ref naming created by the `create-topic.sh` script
* root topic doc: `topic-name_index`
* each other doc: `topic-name_docname`
	* where `docname` is: objectives, commands, studio, walkthrough

## project docs

### dir structure
```sh
src/projects/
  theme/
    project.rst <— week overview / collection of POs
    objective-name.rst <— doc dedicated to a primary objective
    objective-collection-name/ <— ordered sequence of tasks for the objective to be completed
      1-objective-task-name.rst <— a task document related to the objective
```

### using project docs in a **week document**:
	* entire week dedicated to project: ref the `projects/theme/project.rst`
	* partial week: ref directly to the `projects/theme/objective.rst[objective-collection/index.rst]`
	
### ref naming
* root project theme doc: `theme_index`
* objective doc: `theme_objective-name`
* objective collection (multiple sequential tasks for one objective):
	* objective collection root doc:  `theme_objective-name_index`
	* objective collection task: `theme_objective-name_task-name`

## week docs

### dir structure
* each week is its own file that is composed as needed (see below)
* moving weeks around is as simple as changing the file name and the theme title

```sh
src/weeks/
  week-##.rst <-- composable week doc (one for each week)
```

## week doc structure
* allows for each week to be composed of topics and / or project days
* moving around the content of each week is as simple as changing the ref and theme title
* these docs are easy to change and become the sources of truth for the cohort’s schedule
* the root `src/index.rst` toctree uses globs for the `src/weeks/` dir and goes to a depth of 2 to show both the week theme and nested day themes under it

```sh
====================
Week ##: Theme Title
====================

Day #: Day Theme Title
======================

days are composed by referencing topics, projects, or project objectives as needed

- :ref:`topic-name_index` 
- :ref:`project-theme_index`
- :ref:`project-theme_objective-name`
- :ref:`project-theme_objective-collection_index`

(repeat for each day)
```

# RST Syntax
> headers
```markdown
# special H1 at top of page
# used to build the name when referenced elsewhere
================
[H1] Page Header
================

[H1] Section Header
===================

[H2]  Sub Section Header
------------------------

[H3] Sub-Sub Section Header
^^^^^^^^^^^^^^^^^^^^^^^^^^^
```

> admonitions
* `definition` block? For terminilogy

---

# Curriculum Docs Boilerplate

# About this Repository

This repository is a template to be used to create curriculum sites for LaunchCode education purposes.

## How to Use this Repository

Create a new LaunchCode curriculum site using this template as a starting point. 
Maintain this template as an upstream repository so that you may incorporate any updates made here into your 
curriculum. 

### Customize conf.py

Change ``site_theme_options.navbar_title`` and ``project`` to match your curriculum content.

## Disclaimer

Some LaunchCode Education book sites use a modified version of this template called [Curriculum Book Template](https://github.com/LaunchCodeEducation/curriculum-book-template).