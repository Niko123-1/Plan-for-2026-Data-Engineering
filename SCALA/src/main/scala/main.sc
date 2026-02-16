object StringProcessor {
  def processStrings(strings: List[String]): List[String] = {
    // Используем filter вместо цикла для отбора элементов
    // Используем map вместо ручного добавления в список
    // Избавляемся от изменяемой переменной result
    // Используем цепочку вызовов методов коллекций
    strings
      .filter(str => str.length > 3)  // Оставляем только строки длиннее 3 символов
      .map(str => str.toUpperCase)     // Преобразуем их в верхний регистр
  }

  def main(args: Array[String]): Unit = {
    val strings = List("apple", "cat", "banana", "dog", "elephant")
    val processedStrings = processStrings(strings)
    println(s"Processed strings: $processedStrings")
  }
}