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

document.addEventListener("DOMContentLoaded", function() {
  document.getElementById("begin_button").addEventListener("click", function() {
    const now = new Date();
    const datetimeString = now.getFullYear() + '-' + 
                           ('0' + (now.getMonth() + 1)).slice(-2) + '-' + 
                           ('0' + now.getDate()).slice(-2) + ' ' + 
                           ('0' + now.getHours()).slice(-2) + ':' + 
                           ('0' + now.getMinutes()).slice(-2) + ':' + 
                           ('0' + now.getSeconds()).slice(-2);

    // 時刻をモーダルとhidden fieldに設定
    document.getElementById("display_time").textContent = datetimeString;
    document.getElementById("attendance_begin_at").value = datetimeString;

    // モーダルを表示
    document.getElementById("begin_modal").style.display = "block";
    document.getElementById("modal_overlay").style.display = "block";
  });
});
