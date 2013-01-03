#= require test_helper

describe 'Picture', ->
  picture = null

  beforeEach ->
    picture = new $.Picture()

  it 'should have default values', ->
    assert.equal picture.urlRoot, '/instagram_pops'
    assert.equal picture.get('username'), 'Jane'
    assert.equal picture.get('caption'), '#fall #fashion'
    assert.equal picture.get('comments_count'), 0
    assert.equal picture.get('likes_count'), 0
    assert.equal picture.get('link'), 'http://instagr.am/p/S_YBrAB_FX/'
    assert.equal picture.get('low_resolution_url'), 'http://distilleryimage6.s3.amazonaws.com/2f540c98423911e29d0322000a1f97e3_6.jpg'
    assert.equal picture.get('standard_resolution_url'), 'http://distilleryimage7.s3.amazonaws.com/372d9136417c11e2882622000a1f985d_7.jpg'
