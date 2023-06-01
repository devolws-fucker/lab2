import com.google.gson.Gson;
import com.google.gson.reflect.TypeToken;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.FileReader;
import java.io.FileWriter;
import java.io.IOException;
import java.nio.charset.StandardCharsets;
import java.util.ArrayList;
import java.util.List;

@WebServlet(name = "CarServlet", urlPatterns = {"/CarServlet"})
public class CarServlet extends HttpServlet {
    private static final String FILE_PATH = "cars.json";
    private static final Gson GSON = new Gson();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException {
        List<Car>cars;
        try (FileReader reader = new FileReader(FILE_PATH, StandardCharsets.UTF_8)) {
            cars = GSON.fromJson(reader, new TypeToken<List<Car>>() {}.getType());
        } catch (IOException e) {
            cars = new ArrayList<>();
        }

        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        response.getWriter().write(GSON.toJson(cars));
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException {
        Car car = GSON.fromJson(request.getReader(), Car.class);

        List<Car> cars;
        try (FileReader reader = new FileReader(FILE_PATH, StandardCharsets.UTF_8)) {
            cars = GSON.fromJson(reader, new TypeToken<List<Car>>() {}.getType());
        } catch (IOException e) {
            cars = new ArrayList<>();
        }

        cars.add(car);

        try (FileWriter writer = new FileWriter(FILE_PATH, StandardCharsets.UTF_8)) {
            GSON.toJson(cars, writer);
        }

        response.setStatus(HttpServletResponse.SC_CREATED);
    }
}