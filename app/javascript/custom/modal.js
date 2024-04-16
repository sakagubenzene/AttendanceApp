document.addEventListener("turbo:load", function() {
  const overlay = document.getElementById("modal_overlay");
  
  document.getElementById("begin_button").addEventListener("click", function() {
    document.getElementById("begin_modal").style.display = "block";
    overlay.style.display = "block";
  });

  document.getElementById("finish_button").addEventListener("click", function() {
    document.getElementById("finish_modal").style.display = "block";
    overlay.style.display = "block";
  });

  const closeButtons = document.querySelectorAll(".close-modal");
  closeButtons.forEach(button => {
    button.addEventListener("click", function() {
      document.querySelector(".modal[style*='block']").style.display = "none";
      overlay.style.display = "none";
    });
  });

  overlay.addEventListener("click", function() {
    document.querySelector(".modal[style*='block']").style.display = "none";
    this.style.display = "none";
  });
  
});

document.addEventListener("DOMContentLoaded", function() {
  if (document.body.id === 'new_attendance') {
    function updateTime() {
      const currentTimeDisplay = document.getElementById('current_time');
      if (currentTimeDisplay) {
        const now = new Date();
        currentTimeDisplay.textContent = now.toLocaleTimeString();
      }
    }
    setInterval(updateTime, 1000);
    updateTime();
  }
});
