import os

# -- Project Information -----------------------------------------------------

# Dynamic version read from project root
current_dir = os.path.dirname(os.path.abspath(__file__))
version_file = os.path.abspath(os.path.join(current_dir, '..', '..', 'VERSION'))

try:
    with open(version_file, 'r') as f:
        content = f.read().strip()
        if 'echo "' in content:
            release = content.split('"')[1]
        else:
            release = content
except Exception:
    release = '0.0.1'

project = 'ADM'
copyright = '2026, Hadi Mottale'
author = 'Hadi Mottale'
version = release

# -- General Configuration ---------------------------------------------------
extensions = [
    'myst_parser',
    'sphinx_design',
    'sphinx_sitemap',
    'sphinx_rtd_theme',
    'sphinx_copybutton',
    'sphinx_multiversion',
    'sphinx_last_updated_by_git',
]

templates_path = ['_templates']
exclude_patterns = [
    '_build',
    'Thumbs.db',
    '.DS_Store'
]
language = 'fa'

# -- HTML Output Options -----------------------------------------------------
html_theme = 'sphinx_rtd_theme'
html_static_path = ['_static']

# -- Theme Options & Navigation ----------------------------------------------
html_theme_options = {
    'logo_only': False,
    'prev_next_buttons_location': 'bottom',
    'style_external_links': True,
}

# -- Sidebar Configuration --------------------------------------------------
# Note: sphinx_rtd_theme has its own sidebar logic, but you can customize if needed
html_sidebars = {
    '**': [
        'searchbox.html',
        'navigation.html',
    ]
}

# -- SEO Configuration
html_baseurl = 'https://adm.dataist.ir/'

# -- Sphinx Multiversion Configuration ----------------------------------------
smv_branch_whitelist = r'^(main|master)$'
smv_tag_whitelist = r'^v\d+\.\d+(\.\d+)?$'
smv_remote_whitelist = None

