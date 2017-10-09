defmodule Discuss.TopicController do
  use Discuss.Web, :controller

  alias Discuss.Topic

  def index(conn, _params) do
    IO.inspect conn.assigns
    topics = Repo.all(Topic)
    render conn, "index.html", topics: topics
  end

  def new(conn, _params) do
    changeset = Topic.changeset(%Topic{}, %{})

    render conn, "new.html", changeset: changeset
  end

  def show(conn, %{"id" => id}) do
    topic = Repo.get(Topic, id)

    render conn, "topic.html", topic: topic
  end

  def delete(conn, %{"id" => id}) do
    Repo.get!(Topic, id)
    |> Repo.delete!

    conn
    |> put_flash(:info, "Topic deleted successfully.")
    |> redirect(to: topic_path(conn, :index))
  end

  def edit(conn, %{"id" => topic_id}) do
    topic = Repo.get(Topic, topic_id)
    changeset = Topic.changeset(topic, %{})

    render conn, "edit.html", changeset: changeset, topic: topic
  end

  def update(conn, %{"id" => id, "topic" => topic}) do
    old_topic = Repo.get(Topic, id)
    changeset = old_topic |> Topic.changeset(topic)

    case Repo.update(changeset) do
      {:ok, _topic} ->
        conn
        |> put_flash(:info, "Topic Updated.")
        |> redirect(to: topic_path(conn, :index))
      {:error, changeset} ->
        render conn, "edit.html", changeset: changeset, topic: old_topic
    end
  end

  def create(conn, %{"topic" => topic}) do
    changeset = Topic.changeset(%Topic{}, topic)

    case Repo.insert(changeset) do
      {:ok, _topic}         ->
        conn
        |> put_flash(:info, "Topic Created.")
        |> redirect(to: topic_path(conn, :index))
      {:error, changeset} ->
        render conn, "new.html", changeset: changeset
    end
  end
end
