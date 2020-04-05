module.exports = {
  title: "Good Night API",
  description: "Decision explainations and project documentation",
  themeConfig: {
    lastUpdated: "Last Updated",
    nav: [
      { text: "Home", link: "/" },
      { text: "Explaination", link: "/explaination/" },
      { text: "Documentation", link: "/documentation/" },
      { text: "GitHub", link: "https://github.com/manhcuongdtbk/good-night-api-rails" },
    ],
    sidebar: {
      "/explaination/": getExplainationSidebar(),
      "/documentation/": getDocumentationSidebar(),
    },
    smoothScroll: true,
  },
};

function getExplainationSidebar() {
  return ["", "choosing-vuepress", "choosing-serializer"];
}

function getDocumentationSidebar() {
  return ["", "database-design", "api-endpoints"];
}
