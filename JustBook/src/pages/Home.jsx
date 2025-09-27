import MovieCard from "../components/MovieCard";
import "./Home.css";

const movies = [
  { id: 1, title: "Inception", genre: "Sci-Fi", poster: "https://via.placeholder.com/300x400?text=Inception" },
  { id: 2, title: "Interstellar", genre: "Adventure", poster: "https://via.placeholder.com/300x400?text=Interstellar" },
  { id: 3, title: "The Dark Knight", genre: "Action", poster: "https://via.placeholder.com/300x400?text=Dark+Knight" }
];

export default function Home() {
  return (
    <div>
      <div className="hero">
        <h1>Book Your Favorite Movies Online</h1>
        <p>Fast, easy, and convenient booking at JustBook</p>
      </div>

      <div className="container">
        <h2>Now Showing</h2>
        <div className="movies-grid">
          {movies.map((movie) => (
            <MovieCard key={movie.id} movie={movie} />
          ))}
        </div>
      </div>
    </div>
  );
}
