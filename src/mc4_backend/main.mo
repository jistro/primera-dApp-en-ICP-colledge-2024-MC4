import Text "mo:base/Text";
import Nat "mo:base/Nat";
import Map "mo:base/HashMap";
import Debug "mo:base/Debug";
import Buffer "mo:base/Buffer";

actor {
  stable var contador = 1;

  type metadataSaludo = {
    nombre : Text;
    texto : Text;
  };

  type idSaludo = Text;

  let libroVisitas = Map.HashMap<idSaludo, metadataSaludo>(0, Text.equal, Text.hash);

  public func crearSaludo(datos : metadataSaludo) : async (Nat) {
    if (datos.nombre == "") {
      Debug.trap("El nombre no puede ser vacío");
    };

    if (datos.texto == "") {
      Debug.trap("El texto no puede ser vacío");
    };

    libroVisitas.put(Nat.toText contador, datos);

    contador += 1;

    return contador;

  };

  public query func obtenerSaludo(id : Nat) : async (metadataSaludo) {
    let saludo = libroVisitas.get(Nat.toText(id));

    return switch (saludo) {
      case (null) {
        {
          nombre = "";
          texto = "";
        };
      };
      case (?val) { val };
    };
  };

  public query func obtenerNumeroSaludos() : async Nat {
    return contador;
  };

  public query func obtenerSaludos() : async [metadataSaludo] {
    var aux = 1;
    var saludoBuffer = Buffer.Buffer<metadataSaludo>(contador);
    
    return loop {


      let saludo = libroVisitas.get(Nat.toText(aux));

      var saludoPorAgregar = switch (saludo) {
        case (null) {
          {
            nombre = "";
            texto = "";
          };
        };
        case (?val) { val };
      };


      saludoBuffer.add(saludoPorAgregar);

      if (aux >= contador) {
        return Buffer.toArray(saludoBuffer);
      } else {
        aux +=1;
      };
      
    };

  };

};