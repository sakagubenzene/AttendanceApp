document.addEventListener("turbo:load", function() {
  initializeClock();
  setupModalHandlers();
});

function initializeClock() {
  if (document.body.id === 'new_attendance') {
    const currentTimeDisplay = document.getElementById('current_time');
    const updateClock = function() {
      if (currentTimeDisplay) {
        const now = new Date();
        currentTimeDisplay.textContent = now.toLocaleTimeString();
      }
    };
    setInterval(updateClock, 10000000000000000000000000);
    updateClock();
  }
}
function setupModalHandlers() {
  const overlay = document.getElementById("modal_overlay");
  document.getElementById("begin_button").addEventListener("click", function() {
    document.getElementById("begin_modal").style.display = "block";
    overlay.style.display = "block";

    const now = new Date();
    const datetimeString = now.getFullYear() + '-' + 
                            ('0' + (now.getMonth() + 1)).slice(-2) + '-' + 
                            ('0' + now.getDate()).slice(-2) + ' ' + 
                            ('0' + now.getHours()).slice(-2) + ':' + 
                            ('0' + now.getMinutes()).slice(-2) + ':' + 
                            ('0' + now.getSeconds()).slice(-2);
    document.getElementById("attendance_begin_at").value = datetimeString;
    document.getElementById("display_time").textContent = datetimeString;
  });

  document.getElementById("finish_button").addEventListener("click", function() {
    document.getElementById("finish_modal").style.display = "block";
    overlay.style.display = "block";
  });

  document.querySelectorAll(".close-modal").forEach(button => {
    button.addEventListener("click", function() {
      document.querySelector(".modal[style*='block']").style.display = "none";
      overlay.style.display = "none";
    });
  });

  overlay.addEventListener("click", function() {
    document.querySelector(".modal[style*='block']").style.display = "none";
    this.style.display = "none";
  });
}