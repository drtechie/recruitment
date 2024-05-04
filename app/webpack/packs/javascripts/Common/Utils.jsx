export function capitalizeFirstLetter(string) {
  return string.charAt(0).toUpperCase() + string.slice(1);
}

export function getAttemptStateLabel(state) {
  switch (state) {
    case 'reviewed':
      return 'magenta';
    case 'submitted':
      return 'blue';
    case 'in_progress':
      return 'orange';
    default:
      return '#DDE65B';
  }
}


export const htmlWithLineBreaks = (textWithLineBreaks) => {
  return textWithLineBreaks.replace(/\n/g, '<br>');
}
