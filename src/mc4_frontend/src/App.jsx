import { useState } from "react";
import { mc4_backend } from "declarations/mc4_backend";

function App() {
  const [saludos, setSaludos] = useState(undefined);

  function mandarSaludo() {
    const nombre = document.querySelector('input[placeholder="Nombre"]').value;
    const texto = document.querySelector('input[placeholder="Texto"]').value;
    mc4_backend.crearSaludo({ nombre, texto }).then((output) => {
      console.log(output);
    });
  }

  function devolverSaludos() {
    mc4_backend.obtenerSaludos().then((output) => {
      //console.log(output);
      setSaludos(output);
      console.log(saludos);
    });
  }

  return (
    <main>
      <img src="/logo2.svg" alt="DFINITY logo" />
      <br />
      <br />
      <div>
        <input type="text" placeholder="Nombre" />
        <input type="text" placeholder="Texto" />
        <button onClick={mandarSaludo}>Mandar saludo</button>
        <button onClick={devolverSaludos}>Devolver saludos</button>
        {saludos && (
          <>
            {saludos.map((saludo, i) => (
              <div key={i}>
                <h3>{saludo.nombre}</h3>
                <p>{saludo.texto}</p>
              </div>
            ))}
          </>
        )}
      </div>
    </main>
  );
}

export default App;
