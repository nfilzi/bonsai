import { Application } from "stimulus";
import { definitionsFromContext } from "stimulus/webpack-helpers";

const setupStimulus = () => {
  const application = Application.start();
  const context = require.context("../controllers", true, /\.js$/);

  application.load(definitionsFromContext(context));
};

export { setupStimulus };
