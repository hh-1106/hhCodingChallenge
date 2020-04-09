/**
 *
 * @author Florian Strohm
 *
 **/

import java.util.LinkedList;
import java.awt.Menu;
import java.awt.MenuBar;
import java.awt.MenuItem;
import processing.awt.PSurfaceAWT;

private int cellSize = 35;
private boolean[][] oldBoard = new boolean[28][28];
private boolean[][] board = new boolean[28][28];

PFont font;
PFont fontBold;

private color black = color(40);
private color darkBlue = color(40, 142, 175);
private color blue = color(70, 182, 245);
private color blackHover = color(30);
private color darkBlueHover = color(40, 132, 175);
private color red = color(220, 20, 70);
private color yellow = color(195, 152, 50);
private color darkGray = color(80);
private color white = color(255);
private color green = color(141, 232, 51);
private color greenHover = color(121, 205, 41);
private color darkGreen = color(91, 153, 29);
private color darkGreenHover = color(75, 130, 24);

private boolean start;
private boolean cameraCentered = true;
private double time;

void setup() {
  size(1351, 985, P3D);
  ortho(-width/2, width/2, -height/2, height/2);
  time = System.currentTimeMillis();
  font = createFont("Calibri", 16, true);
  fontBold = createFont("Calibri Bold", 16, true);
  noStroke();
}

void draw() {
  background(darkGray);
  renderCells();
  if (start && (time+100 < System.currentTimeMillis())) {
    time = System.currentTimeMillis();
    calcNextGeneration();
  }
}

/*
 *
 * This function calculates which cells die and which cells are born
 * according to the rules of Conway's game of life and updates the board accordingly.
 *
 */
private void calcNextGeneration() {
  boolean[][] newBoard = new boolean[28][28];
  for (int i = 0; i < board.length; i++) {
    for (int j = 0; j < board[0].length; j++) {
      int livingNeighbors = calcLivingNeighbors(i, j);
      // Cell dies if it has less than 2 or more than 3 neighbors.
      if (livingNeighbors < 2 || livingNeighbors > 3) {
        newBoard[i][j] = false;
      } else if (livingNeighbors == 2) {
        newBoard[i][j] = board[i][j];
      } else if (livingNeighbors == 3) {
        newBoard[i][j] = true;
      }
    }
  }
  oldBoard = board;
  board = newBoard;
}

/*
 *
 * Calculates the number of living neighbors of a specific cell.
 * This is needed to determine if this specific cell is going to die or be born.
 *
 */
private int calcLivingNeighbors(int column, int row) {
  int neighbors = 0;
  for (int i = column-1; i <= column+1; i++) {
    for (int j = row-1; j <= row+1; j++) {
      if (!(i==column && j==row)) {
        int x = i;
        int y = j;
        if (x < 0) {
          x = 27;
        } else if (x > 27) {
          x = 0;
        }
        if (y < 0) {
          y = 27;
        } else if (y > 27) {
          y = 0;
        }
        if (board[x][y]) {
          neighbors++;
        }
      }
    }
  }
  return neighbors;
}

private void renderCells() {
  // Draw cells
  for (int i = 0; i < board.length; i++) {
    for (int j = 0; j < board[0].length; j++) {
      pushMatrix();
      translate(i*cellSize+188, j*cellSize+20);
      lights();
      if (!board[i][j]) {
        fill(darkBlue);
        box(30);
      } else {
        if (oldBoard[i][j]) {
          fill(darkGreen);
          box(30, 30, 70);
        } else {
          fill(green);
          box(30, 30, 50);
        }
      }
      popMatrix();
    }
  }

  // Create hover effect
  if (cameraCentered) {
    int x = (mouseX-173)/cellSize;
    int y = (mouseY-5)/cellSize;
    if (x < 28 && y < 28 && x >=0 && y >=0) {
      pushMatrix();
      translate(x*cellSize+188, y*cellSize+20);
      lights();
      if (!board[x][y]) {
        fill(darkBlueHover);
        box(30);
      } else if (board[x][y]) {
        if (oldBoard[x][y]) {
          fill(darkGreenHover);
          box(30, 30, 70);
        } else {
          fill(greenHover);
          box(30, 30, 50);
        }
      }
      popMatrix();
    }
  }
}

/*
*
 * These primitives store the current mouse position.
 * This is needed to prevent multiple mouseDragged() events on the same cell.
 *
 */
int currentMouseX = -1;
int currentMouseY = -1;

/*
*
 * This function triggers if any mouse button is pressed.
 * It checks if any cell was clicked and creates or deletes a wall accordingly.
 *
 */
void mousePressed() {
  if (cameraCentered) {
    currentMouseX = (mouseX-173)/cellSize;
    currentMouseY = (mouseY-5)/cellSize;
    if (currentMouseX < 28 && currentMouseY < 28 && currentMouseX >=0 && currentMouseY >=0) {
      if (mouseButton == LEFT) {
        board[currentMouseX][currentMouseY] = true;
      } else if (mouseButton == RIGHT) {
        board[currentMouseX][currentMouseY] = false;
      }
    }
  }
}

/*
*
 * This function triggers if the mouse is moved with any mouse button pressed.
 * It checks if the mouse is dragged over any cell and creates or deletes a wall accordingly.
 *
 */
void mouseDragged() {
  if (cameraCentered) {
    int currentMouseX = (mouseX-173)/cellSize;
    int currentMouseY = (mouseY-5)/cellSize;
    if (currentMouseX < 28 && currentMouseY < 28 && currentMouseX >=0 && currentMouseY >=0) {
      if (this.currentMouseX != currentMouseX || this.currentMouseY != currentMouseY) {
        this.currentMouseX = currentMouseX;
        this.currentMouseY = currentMouseY;
        if (mouseButton == LEFT) {
          board[currentMouseX][currentMouseY] = true;
        } else if (mouseButton == RIGHT) {
          board[currentMouseX][currentMouseY] = false;
        }
      }
    }
  } else {
    camera(width/8, mouseX-180, (height/2) / tan(PI/6), width/2, height/2, 0, 0, 0, -1);
  }
}

void mouseMoved() {
  if (!cameraCentered) {
    camera(width/8, mouseX-180, (height/2) / tan(PI/6), width/2, height/2, 0, 0, 0, -1);
  }
}

/*
*
 * This function triggers if any key was released.
 * It checks what specific key was pressed and performes some action accordingly.
 *
 */
void keyReleased() {
  if (key =='s' || key == 'S') {
    start = !start;
  } else if (key =='d' || key == 'D') {
  } else if (key =='c' || key == 'C') {
    if (cameraCentered) {
      camera(width/8, mouseX-180, (height/2) / tan(PI/6), width/2, height/2, 0, 0, 0, -1);
      cameraCentered = false;
    } else {
      camera();
      cameraCentered = true;
    }
  } else if (key =='r' || key == 'R') {
    board = new boolean[28][28];
    camera();
    cameraCentered = true;
    start = false;
  } else if (key =='a' || key == 'A') {
  }
}
