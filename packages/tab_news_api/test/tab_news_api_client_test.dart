import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mocktail/mocktail.dart';
import 'package:tab_news_api/tab_news_api.dart';

class MockHttpClient extends Mock implements http.Client {}

class MockResponse extends Mock implements http.Response {}

class FakeUri extends Fake implements Uri {}

void main() {
  group("[TabNews Api group test]", () {
    late http.Client httpClient;
    late TabNewsAPiClient apiClient;
    late List<Map<String, dynamic>> dummyResponse;

    setUpAll(() {
      registerFallbackValue(FakeUri());
    });

    setUp(() {
      httpClient = MockHttpClient();
      apiClient = TabNewsAPiClient(httpClient: httpClient);
      dummyResponse = [
        {
          "id": "54bc6582-dcbd-4711-bee8-7be0d90380cf",
          "owner_id": "db6c12e1-fa5d-4ca4-a3cb-32b7d06ee51c",
          "parent_id": null,
          "slug": "parei-de-me-sentir-burro-agora-a-programacao-faz-sentido",
          "title": "Parei de me sentir burro:  Agora a programação faz sentido",
          "body":
              "Por muito tempo, boa parte dos meus estudos sobre programação, eu me sentia burro. Por muitas vezes eu achava que isso não era pra mim e que devia tentar outra area. \n\nMuitos acham que programar é fácil, que abstrair problemas é fácil. Isso é uma doce ilusão de todos - ou a maioria dos iniciantes. A area de T.I é dificil, sim. Requer muita resiliencia, paciencia e por vezes o resultado demora a aparecer. Também precisa de inteligencia.\n\nE quando eu falo inteligencia, não estou me referindo a um dom, ou saber tudo como se fosse uma enciclópedia. Estou falando de sentar a bunda na cadeira e pesquisar, ler e não ter preguiça de fazer isso ou achar que só um tutorial no Youtube resolve, ou que aquele curso vai ter todo o conhecimento que tu precisa e voce so precisa assistir e vai sair colocando tudo em pratica sem erros.\n\nProgramar é um eterno loop de praticar => Errar => Pesquisar o erro => praticar. \n\nEu demorei muito para entender isso. Achava que só asssitir o tutorial e ver a aula do curso seria suficiente. Que depois era só abrir o VS Code e eu iria aplicar aquele conhecimento perfeitamente, sem erros. Na minha cabeça tudo teria que rodar de primeira e se tivesse erros eu era burro por deixa-lo acontecer.\n\nA cada log de erro, eu me desesperava, já perdia a racionalidade e na mesma hora passava na minha cabeça pensamentos do tipo \"eu sou muito burro\", \"nunca vou aprender isso\", \"programação realmente é para mim?\". O resultado disso era sindrome do impostor, ansiedade e procastinação por medo de errar novamente.\n\nE como eu mudei esse cenário?\n\nO primeiro passo que dei, foi buscar ajuda. Como eu não tinha dinheiro para um psicologo, eu comecei a consunmir contéudos sobre desenvolvimento pessoal. De inicio eu achava isso uma tremenda besteira,... e olha lá, mais um equivoco meu, mais um preconceito...\n\nFoi nessa minha trajetória buscando um desenvolvimento pessoal que conheci o Eslen Delanogare, Nunca canso de falar que esse cara salvou minha vida. De primeiro, eu consumi seus contéudos gratuitos e depois eu assinei o[ Reservatório de Dopamina](https://reservatoriodedopamina.com.br/). Onde o Eslen da aula sobre desenvolvimento pessoal. Não vou me aprofundar aqui pois não é o intuito do post.\n\nO segundo passo que dei, foi ver se eu realmente queria ser programador ou se eu só estava indo pelo hype. Comecei a ter uma visão minha em terceira pessoa, como se fosse um filme. Nas minhas memória eu naveguei em busca da resposta para esta questão. Naveguei até quando tinha 16 anos, quando pedi a minha mãe um PC para estudar.\n\nE o primeiro questionamneto dela foi \"Você vai realmente estudar ou é para jogar?\"\n\nEu insisti e disse que era pra estudar, que eu precisava de um computador porque queria estuadar programação. Eu esperei ansiosamento por 2 anos até ela conseguir comprar. E ate essa data chegar, eu ficava assistindo contéudos sobre programação no Youtube. Tudo aquilo me fascinava, ver as pessoas criando as coisas com linhas de codigos. Eu ficava me imaginando fazendo aquilo um dia.\n\nQuando finalmente consegui o PC, a primeira coisa que fiz ao ligar foi correr para o Youtube, para o canal do Guanabara e vi um curso de HTML e CSS dele. Quando eu fiz meu primeiro hello, world aparecer no meu navegador com HTML, eu fiquei muito feliz, aquela sensação foi maravilhiosa. E quando fiz meu primeiro console.log(\"Hello,world\") no JS foi maior ainda kkk\n\nEntão, a minha resposta para a pergunta se realmente queria ser programador, foi um grande SIM.\n\nE isso teve outros beneficios alem de matar minha duvida, que foi a de não me importar como anda a area, as contratações, layoff, etc. Eu sei que um dia a minha vez vai chegar e eu so tenho que trabalhar firme ate la. Isso me blindou de mais esse obstaculo.\n\nE o terceiro passo foi construir uma base sólida. Fui um gafanhoto ansioso e pulei essa parte. Depois de pesquisas, cheguei ao curso CS50 de Harvard e após construir uma boa base eu dei o proximo passo.\n\nO quarto passo foi escolher qual linguegem eu queria me especializar e aonde eu queria me especializar numa area tão abrangente. Assim, eu tirei quase 2 meses para fazer pesquisas e pesquisar diversas linguagens. Passei por Ruby, Python, Go, Java, C#.\n\nQuando cheguei no C#, pode-se dizer que foi paixão a primeira vista. Eu realmetne gostei muito dessa linguagem e resolvi que vou entrar na area através dela. Então eu estudo C# e decidi fazer uma faculdade para conseguir estagio. Começo proximo ano.\n\nE essa trajetória até  aqui é curta, mas de enorme aprendizado. Eu adquiri experiencias valiosas, que me fizeram parar de me sentir burro e a programação começou a fazer sentido.\n\nIsso também se deve a minha nova forma de estudar, que consiste em ver aulas, ler docs, praticar, errar, aprender com o erro e praticar de novo. \n\nE quando praticamos, conseguimos identificar melhor o que precisamos aprender, o que sabemos e o que não sabemos.\n\nOutra coisa extremamente importante é a curiosidade. Por muitas vezes eu ficava me pergutando como o VS Code alerta erro quando erramos a sintaxe, ou o que acontece para o resultado do código aparecer no terminal, por exemplo.\n\nFoi indo pesquisar sobre isso que eu descobri o Vim. Achei extremamente interessante um editor de texto que roda no terminal e que você só usa teclado. Fui instalar ele para usar, descobri que ele tem varias distro, como LunarVim, AstroVim, Neovim. Então eu escolhi usar o Neovim e uso até hoje.\n\nNo processo de instalação eu descobri o LSP e ai minha resposta para a dúvida anterior veio. Quando estava configurando o LSP, eu descobri Lintter, formatter.\n\nE o melhor de tudo é que eu instalei tudo pesquisando, lendo docs, pesquisando no StackOverflow\nA cada erro, uma nova pesquisa, a cada pesquisa, um novo conhecimendo, a cada conhecimento uma experiencia e com a experiencia, cada erro semelhante aquele que enfrentei eu já sei o que fazer e se não souber, sei onde pesquisar para encontrar as respostas.\n\nIsso me trouxe um insight muito importe sobre o que é programação e como realmente se estuda programação. Eu escrevi tudo isso para te dizer como eu parei de me sentir burro e como a programação começou a fazer sentido. Eu sei que não sei de tudo. E o desespero por encontrar um erro se transformou em felicidade por pesquisar e aprender algo novo.\n\nO resultado é que tudo começou a fazer sentido. Cada vez que tenho que codar, eu sinto que meu poder de abstração aumentou. Sei o que fazer. Se não souber, sei por onde começar e sei dar os primeiros passos. \n\nAgora os erros me guiam. Os erros fazem parte do aprendizado.\n\nSe você leu até aqui, muito obrigado.\nSe você esta passando por algo igual. Quero te dizer que não desista. Eu não quero que você se arrependa daqui a 2-3 anos por ter largado programação quando ficou dificil. (como já dizia o Lucas Montado, do canal Lucas Montano).",
          "status": "published",
          "source_url": null,
          "created_at": "2023-11-12T11:31:05.795Z",
          "updated_at": "2023-11-12T11:31:05.795Z",
          "published_at": "2023-11-12T11:31:05.829Z",
          "deleted_at": null,
          "owner_username": "marcosviniciusftd",
          "tabcoins": 11,
          "children_deep_count": 9
        }
      ];
    });

    group("Client Constructor Test: ", () {
      test("Should return a TabNewsClientApi", () {
        // assert
        expect(apiClient, isA<TabNewsAPiClient>());
        expect(apiClient, isNotNull);
      });
    });

    group("getNews", () {
      test("Make a successful request", () async {
        final response = MockResponse();
        when(() => response.statusCode).thenReturn(200);
        when(() => response.body).thenReturn(jsonEncode(dummyResponse));
        when(() => httpClient.get(any())).thenAnswer((_) async => response);
        final result = await apiClient.getNews();
        expect(result, isA<List<NewsModel>>());
      });

      test("Throw an Error if statuscode != 200", () async {
        final response = MockResponse();
        when(() => response.statusCode).thenReturn(400);
        when(() => httpClient.get(any())).thenAnswer((_) async => response);
        expect(() => apiClient.getNews(), throwsA(isA<NewsRequestFailure>()));
      });

      test("Throw an Error if api response does not contain data", () async {
        final response = MockResponse();
        when(() => response.statusCode).thenReturn(200);
        when(() => response.body).thenReturn(jsonEncode([]));
        when(() => httpClient.get(any())).thenAnswer((_) async => response);
        expect(() => apiClient.getNews(), throwsA(isA<NewsNotFoundFailure>()));
      });
    });

    group("getSelectedNews", () {
      test("Successfully fetch a news", () async {
        final response = MockResponse();
        when(() => response.statusCode).thenReturn(200);
        when(() => response.body).thenReturn(jsonEncode(dummyResponse[0]));
        when(() => httpClient.get(any())).thenAnswer((_) async => response);
        final result =
            await apiClient.getSelectedNews(ownerName: "", newsSlug: "");
        expect(result, isA<NewsModel>());
      });

      test(
          "Should Thrown an Error if get a statuscode != 200 when getting a selected news",
          () async {
        final response = MockResponse();
        when(() => response.statusCode).thenReturn(400);
        when(() => httpClient.get(any())).thenAnswer((_) async => response);
        expect(() => apiClient.getSelectedNews(ownerName: "", newsSlug: ""),
            throwsA(isA<SelectedNewsRequestFailure>()));
      });

      test("Should Thow an error if the news is empty", () async {
        final response = MockResponse();
        when(() => response.statusCode).thenReturn(200);
        when(() => response.body).thenReturn(jsonEncode({}));
        when(() => httpClient.get(any())).thenAnswer((_) async => response);
        expect(() => apiClient.getSelectedNews(ownerName: "", newsSlug: ""),
            throwsA(isA<SelectedNewsNotFoundFailure>()));
      });
    });

    group("getComents", () {
      test("Should successfully get a news comments", () async {
        final response = MockResponse();
        when(() => response.statusCode).thenReturn(200);
        when(() => response.body).thenReturn(jsonEncode(dummyResponse));
        when(() => httpClient.get(any())).thenAnswer((_) async => response);
        final result = await apiClient.getComments(
          ownerName: "",
          newsSlug: "",
        );
        expect(result, isA<List<NewsModel>>());
      });

      test(
          "Should Thrown an Error if get a statuscode != 200 when getting a selected news comments",
          () async {
        final response = MockResponse();
        when(() => response.statusCode).thenReturn(400);
        when(() => httpClient.get(any())).thenAnswer((_) async => response);
        expect(() => apiClient.getComments(ownerName: "", newsSlug: ""),
            throwsA(isA<SelectedNewsCommentsRequestFailure>()));
      });

      test("Should Thow an error if the news comments is empty", () async {
        final response = MockResponse();
        when(() => response.statusCode).thenReturn(200);
        when(() => response.body).thenReturn(jsonEncode([]));
        when(() => httpClient.get(any())).thenAnswer((_) async => response);
        expect(() => apiClient.getComments(ownerName: "", newsSlug: ""),
            throwsA(isA<SelectedNewsCommentsNotFoundFailure>()));
      });
    });
  });
}
