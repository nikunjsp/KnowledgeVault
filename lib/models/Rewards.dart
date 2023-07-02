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
      picture: 'assets/icons/laptop.jpg',
      rewardname: 'bestbuy',
      description:
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.'),
  Rewards(
      picture: 'assets/icons/accounting.jpg',
      rewardname: 'bestbuy',
      description:
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.'),
  Rewards(
      picture: 'assets/icons/design.jpg',
      rewardname: 'bestbuy',
      description:
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.'),
  Rewards(
      picture: 'assets/icons/laptop.jpg',
      rewardname: 'bestbuy',
      description:
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.'),
];
