class PermissionModel {
  bool dashboard;
  bool category;
  bool partner;
  bool earnings;
  bool users;
  bool services;
  bool orders;
  bool pages;
  bool settings;
  bool reports;
  bool support;

  PermissionModel({
    this.dashboard = false,
    this.category = false,
    this.partner = false,
    this.earnings = false,
    this.users = false,
    this.services = false,
    this.orders = false,
    this.pages = false,
    this.settings = false,
    this.reports = false,
    this.support = false,
  });
}