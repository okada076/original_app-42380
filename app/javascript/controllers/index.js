// Import and register all your controllers from the importmap via controllers/**/*_controller
import { application } from "controllers/application"
import StepProgressController from "./step_progress_controller"

application.register("step-progress", StepProgressController)