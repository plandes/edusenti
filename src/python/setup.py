from pathlib import Path
from zensols.pybuild import SetupUtil

su = SetupUtil(
    setup_path=Path(__file__).parent.absolute(),
    name="zensols.edusenti",
    package_names=['zensols', 'resources'],
    # package_data={'': ['*.html', '*.js', '*.css', '*.map', '*.svg']},
    package_data={'': ['*.conf', '*.json', '*.yml']},
    description='Pretraining and sentiment student to instructor review sentiment corpora and analysis.',
    user='plandes',
    project='edusenti',
    keywords=['tooling'],
    # has_entry_points=False,
).setup()
