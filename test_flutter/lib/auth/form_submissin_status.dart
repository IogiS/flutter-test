abstract class FormSubmissionStatus{
   const FormSubmissionStatus();
}

class InitialFormStatus extends FormSubmissionStatus{
   const InitialFormStatus();
}

class FormSubmitting extends FormSubmissionStatus{}

class SubmissionSuccess extends FormSubmissionStatus{}

class SubmissionFailed extends FormSubmissionStatus{
   late final Exception exception;


   SubmissionFailed(this.exception);
}
