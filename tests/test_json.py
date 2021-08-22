import os
import json


class TestJson:

    # Simple validation: if it is not valid json, this will fail.
    with open('lib/filters.json') as f:
        filters = json.load(f)

    def test_transforms(self):

        # Get directories in lib/
        dirs = os.listdir('lib')
        transforms = [d.lower() for d in dirs
                      if os.path.isdir(os.path.join('lib', d))]

        # Assert #dir == #categories
        assert len(self.filters) == len(transforms)

        keys = ['name', 'author', 'year', 'appendix', 'points', 'values',
                'file']

        # Loop over transforms
        for cat, filters in self.filters.items():

            # assert name is in list
            assert cat in transforms

            # Loop over filters
            for f in filters:

                # Check all entries
                assert len(f) == len(keys)
                for k, v in f.items():
                    assert k in keys
                    if k == 'points':
                        assert isinstance(v, int)
                    else:
                        assert isinstance(v, str)

                # Some consistency
                assert cat in f['file']
                assert f['year']+f['appendix'] in f['name']
                assert f['year']+f['appendix'] in f['file']
                assert str(f['points']) in f['name']
                assert str(f['points']) in f['file']
                for v in f['values'].split(','):
                    assert v in f['file']
                assert f['file'].split('.')[-1] == 'txt'

                # Check file exists
                assert os.path.isfile(os.path.abspath(f['file']))
