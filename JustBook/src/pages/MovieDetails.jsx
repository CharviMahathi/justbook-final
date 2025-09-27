import { useParams, useNavigate } from "react-router-dom";

const movies = {
  1: { title: "Inception", description: "A mind-bending sci-fi thriller.", poster: "https://via.placeholder.com/300x400?text=Inception" },
  2: { title: "Interstellar", description: "Journey through space and time.", poster: "https://via.placeholder.com/300x400?text=Interstellar" },
  3: { title: "The Dark Knight", description: "The caped crusader vs Joker.", poster: "https://via.placeholder.com/300x400?text=Dark+Knight" }
};

export default function MovieDetails() {
  const { id } = useParams();
  const navigate = useNavigate();
  const movie = movies[id];

  if (!movie) return <h1 className="p-6">Movie not found</h1>;

  return (
    <div className="p-6 flex flex-col md:flex-row gap-6">
      <img src={movie.poster} alt={movie.title} className="rounded-lg w-64" />
      <div>
        <h1 className="text-2xl font-bold">{movie.title}</h1>
        <p className="mt-2">{movie.description}</p>
        <button
          onClick={() => navigate("/checkout")}
          className="mt-4 bg-green-600 text-white px-6 py-2 rounded"
        >
          Book Tickets
        </button>
      </div>
    </div>
  );
}
