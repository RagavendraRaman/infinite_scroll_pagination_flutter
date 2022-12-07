

class Pagination {
    Pagination({
        this.createdBy,
        this.modifiedBy,
        this.createdAt,
        this.modifiedAt,
        this.messageId,
        this.message,
        this.readedOn,
        this.createdDate,
        this.userType,
    });

    String? createdBy;
    String? modifiedBy;
    String? createdAt;
    String? modifiedAt;
    int? messageId;
    String? message;
    String? readedOn;
    String? createdDate;
    bool? userType;

    factory Pagination.fromJson(Map<String, dynamic> json) => Pagination(
        createdBy: json["createdBy"],
        modifiedBy: json["modifiedBy"],
        createdAt: json["createdAt"],
        modifiedAt: json["modifiedAt"],
        messageId: json["messageId"],
        message: json["message"],
        readedOn: json["readedOn"],
        createdDate: json["createdDate"],
        userType: json["userType"],
    );

    Map<String, dynamic> toJson() => {
        "createdBy": createdBy,
        "modifiedBy": modifiedBy,
        "createdAt": createdAt,
        "modifiedAt": modifiedAt,
        "messageId": messageId,
        "message": message,
        "readedOn": readedOn,
        "createdDate": createdDate,
        "userType": userType,
    };
}