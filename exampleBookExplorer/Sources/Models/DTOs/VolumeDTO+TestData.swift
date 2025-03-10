//
// Created with ❤️ by Daniel Gabzdyl.

import Foundation


extension VolumeDTO {
    
    static let harryPotterAndThePhilosophersStone = VolumeDTO(
        id: "qK3bDAAAQBAJ",
        volumeInfo: .init(
            title: "Harry Potter a Kámen mudrců",
            authors: ["J.K. Rowling"],
            publishedDate: "2016-08-30",
            description: "Harry dopis roztřesenou rukou obrátil a spatřil rudou voskovou pečeť, na které byl erb: velké písmeno B, kolem kterého byli lev, orel, jezevec a had.“ Když se tyto dopisy poprvé objevily na rohožce domu číslo čtyři v Zobí ulici, Harry Potter o Bradavicích nikdy neslyšel. Dopisy z nažloutlého pergamenu s rudou pečetí napsané zeleným inkoustem okamžitě zabavují jeho příšerná teta a strýc. V den Harryho jedenáctých narozenin přináší Rubeus Hagrid, obrovský muž s očima lesklýma jako dva švábi, podivuhodnou zprávu: Harry Potter je kouzelník a je přijatý do Školy čar a kouzel v Bradavicích. Fantastické dobrodružství právě začíná.",
            imageLinks: .init(
                smallThumbnail: "http://books.google.com/books/content?id=qK3bDAAAQBAJ&printsec=frontcover&img=1&zoom=5&source=gbs_api",
                thumbnail: "http://books.google.com/books/content?id=qK3bDAAAQBAJ&printsec=frontcover&img=1&zoom=1&source=gbs_api"
            ),
            infoLink: "http://books.google.cz/books?id=Gq_bDAAAQBAJ&dq=inauthor:%22Rowling%22&hl=&source=gbs_api"
        )
    )
    
    static let testData: [VolumeDTO] = [
        .harryPotterAndThePhilosophersStone
    ]
}
