document.addEventListener("turbo:load", function() {
  if (document.body.id === "new_attendance") {
    setupModalHandlers();
  }
});


function setupModalHandlers() {
  const overlay = document.getElementById("modal_overlay");

  document.getElementById("begin_button").addEventListener("click", function() {
    // begin_buttonクリックでmodal出現
    document.getElementById("begin_modal").style.display = "block";
    overlay.style.display = "block";

    // beginのときにはボタンを押した時刻を参照。記録するvalueも設定。
    const now = new Date();
    const datetimeString = now.getFullYear() + '-' + 
                            ('0' + (now.getMonth() + 1)).slice(-2) + '-' + 
                            ('0' + now.getDate()).slice(-2) + ' ' + 
                            ('0' + now.getHours()).slice(-2) + ':' + 
                            ('0' + now.getMinutes()).slice(-2) + ':' + 
                            ('0' + now.getSeconds()).slice(-2);
    document.getElementById("attendance_begin_at").value = datetimeString;
    document.getElementById("begin_time").textContent = datetimeString;
  });

  document.getElementById("finish_button").addEventListener("click", function() {
    // finish_button押したら発火
    document.getElementById("finish_modal").style.display = "block";
    overlay.style.display = "block";

    // finishなら時間は更新し続ける。記録するvalueはcontrollerまかせ。
    setInterval(setFinishTime, 1000);
  });

  document.querySelectorAll(".close-modal").forEach(button => {
    button.addEventListener("click", function() {
      //ばつボタンでモーダルとオーバーレイ消す。
      document.querySelector(".modal[style*='block']").style.display = "none";
      overlay.style.display = "none";
    });
  });

  overlay.addEventListener("click", function() {
    
    document.querySelector(".modal[style*='block']").style.display = "none";
    this.style.display = "none";
  });
}

function setFinishTime() {
  let now = new Date();
  document.getElementById('finish_time').textContent = now.getFullYear() + '-' + 
  ('0' + (now.getMonth() + 1)).slice(-2) + '-' + 
  ('0' + now.getDate()).slice(-2) + ' ' + 
  ('0' + now.getHours()).slice(-2) + ':' + 
  ('0' + now.getMinutes()).slice(-2) + ':' + 
  ('0' + now.getSeconds()).slice(-2);
}