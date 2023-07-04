class Rewards {
  String picture;
  String rewardname;
  String description;

  Rewards({
    required this.picture,
    required this.rewardname,
    required this.description,
  });
}

List<Rewards> rewardlist = [
  Rewards(
      picture: 'laptop',
      rewardname: 'Bestbuy',
      description:
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.'),
  Rewards(
      picture: 'accounting',
      rewardname: 'Starbucks',
      description:
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.'),
  Rewards(
      picture: 'design',
      rewardname: 'Pizza Pizza',
      description:
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.'),
  Rewards(
      picture: 'laptop',
      rewardname: 'Tim Hortons',
      description:
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.'),
];
