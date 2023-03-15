

"""Helper functions"""
def create_recipe(user, **params):
  """Create and return a sample recipe"""
  defaults = {
    'title': 'Sample recipe title',
    'time_minutes': 22,
    'price': Decimal('5.25'),
    'description': 'Sample description',
    'link': 'http://example.com/recipe.pdf'
  }
  defaults.update(params)

  recipe = Recipe.objects.create(user=user, **defaults)
  return recipe

"""Test class"""
class PrivateRecipeApiTests(TestCase):
  """Test authenticated API requests."""
  def setUp(self):
    self.client = APIClient()
    self.user = create_user(email='user@example.com', password='testpass123')
    self.client.force_authenticate(self.user)

  """Test method"""
  def test_do_something(self):
    """Does something"""
    create_recipe(user=self.user)
    create_recipe(user=self.user)

    res = self.client.get('/recipes/')

    recipes = Recipe.objects.all().order_by('-id')
    serializer = RecipeSerializer(recipes, many=True)
    self.assertEqual(res.status_code, status.HTTP_200_OK)
    self.assertEqual(res.data, serializer.data)

