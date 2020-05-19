public class CaseController {
    
    @AuraEnabled(cacheable=true) 
    public static List<Case> getCases() {
        return [select id, subject, description, status, origin from case];
    }
}