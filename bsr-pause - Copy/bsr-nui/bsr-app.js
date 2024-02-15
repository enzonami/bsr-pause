var bsr_resource = GetParentResourceName();
var bsr_config = {};
var bsr_data = {};
var bsr_jobs = {};

window.addEventListener("message", function(event) {
    let data = event.data;

    if ( data.type == 'show' ) {
        $("#bsr-container").show();
        bsr_config = data.config;
        bsr_data = data.data;
        bsr_jobs = data.jobs;
        bsr_setup_pausemenu();
    } 

    if ( data.type == 'hide' ) {
        $("#bsr-container").hide();
    };
});

function bsr_setup_pausemenu() {
    var translation = bsr_config.bsr_translation;
    var gender = translation.male;
    $('#bsr-jobs').html('');
    $("#bsr-back").html(translation.back);
    $("#bsr-disconnect").html(translation.disconnect);
    $("#bsr-rules-txt").html(translation.rulestitle);
    $("#bsr-rules-rules").html(translation.rules);
    $("#bsr-discord-txt").html(translation.discord);
    $('#bsr-trans-maps').html(translation.maps);
    $("#bsr-trans-tmaps").html(translation.mapstxt);
    $("#bsr-trans-settings").html(translation.settings);
    $("#bsr-trans-tsettings").html(translation.settingstxt);
    if (bsr_data.bsr_gender == 1) {
      gender = translation.female;
    }
    if (bsr_data.bsr_gender == 'm') {
      gender = translation.male;
    }
    if (bsr_data.bsr_gender == 'f') {
      gender = translation.female;
    }
    var charinfo = "\n    <div class=\"bsr-infos-title\">1. <span class=\"bsr-clr\">Character Information.</span></div>\n    <div class=\"bsr-infos-infos\">\n        <div class=\"bsr-infos-box\">\n            <div class=\"bsr-box-ele\"></div>\n            <div class=\"bsr-box-img\" style=\"background-image: url('./bsr-assets/bsr-icon-name.svg');\"></div>\n            <div class=\"bsr-box-infos\">" + translation.fname + ": <span class=\"bsr-clr\">" + bsr_data.bsr_firstName + "</span></div>\n        </div>\n        <div class=\"bsr-infos-box\">\n            <div class=\"bsr-box-ele\"></div>\n            <div class=\"bsr-box-img\" style=\"background-image: url('./bsr-assets/bsr-icon-name.svg');\"></div>\n            <div class=\"bsr-box-infos\">" + translation.lname + ': <span class="bsr-clr">' + bsr_data.bsr_lastName + "</span></div>\n        </div>\n        <div class=\"bsr-infos-box\">\n            <div class=\"bsr-box-img\" style=\"background-image: url('./bsr-assets/bsr-icon-gender.svg');\"></div>\n            <div class=\"bsr-box-infos\">" + translation.gender + ": <span class=\"bsr-clr-sec\">" + gender + "</span></div>\n        </div>\n        <div class=\"bsr-infos-box\">\n            <div class=\"bsr-box-img\" style=\"background-image: url('./bsr-assets/bsr-icon-dob.svg');\"></div>\n            <div class=\"bsr-box-infos\">" + translation.dob + ': <span class="bsr-clr-sec">' + bsr_data.bsr_birthdate + "</span></div>\n        </div>\n        <div class=\"bsr-infos-box\" style=\"width: 100%;\">\n            <div class=\"bsr-box-ele\"></div>\n            <div class=\"bsr-box-img\" style=\"background-image: url('./bsr-assets/bsr-icon-job.svg');\"></div>\n            <div class=\"bsr-box-infos\">" + translation.job + ": <span class=\"bsr-clr\">" + bsr_data.bsr_job + "</span> - <span class=\"bsr-clr\">" + bsr_data.bsr_grade + "</span></div>\n        </div>\n        <div class=\"bsr-infos-box\">\n            <div class=\"bsr-box-img\" style=\"background-image: url('./bsr-assets/bsr-icon-cash.svg');\"></div>\n            <div class=\"bsr-box-infos\">" + translation.cash + ": <span class=\"bsr-clr\">" + bsr_data.bsr_cash + "</span> " + translation.currency + "</div>\n        </div>\n        <div class=\"bsr-infos-box\">\n            <div class=\"bsr-box-img\" style=\"background-image: url('./bsr-assets/bsr-icon-bank.svg');\"></div>\n            <div class=\"bsr-box-infos\">" + translation.bank + ": <span class=\"bsr-clr\">" + bsr_data.bsr_bank + "</span> " + translation.currency + "</div>\n        </div>\n    </div>\n    <div class=\"bsr-triple\" style=\"right: 1.563vw;\"><div class=\"bsr-triple-ele\"></div><div class=\"bsr-triple-ele\"></div><div class=\"bsr-triple-ele\"></div></div>\n    <div class=\"bsr-line\" style=\"top: 1.563vw;\"></div>\n    ";
    $("#bsr-multi-infos").html(charinfo);
    $.each(bsr_jobs, function (_, job) {
      var jobdata = "<div class=\"bsr-job\" style=\"border-color: " + job.color + ";\"><span style=\"color: " + job.color + ";\">" + job.name + ":&nbsp</span>" + job.count + ' ' + job.suivname + "</div>";
      $('#bsr-jobs').append(jobdata);
    });
  }

  $('#bsr-maps').click(function () {
    $.post("https://" + bsr_resource + "/show-maps");
  });
  $("#bsr-settings-main").click(function () {
    $.post("https://" + bsr_resource + "/show-settings");
  });
  $("#bsr-back").click(function () {
    $.post("https://" + bsr_resource + "/hide");
  });
  $("#bsr-disconnect").click(function () {
    $.post("https://" + bsr_resource + "/disconnect");
  });
  $("#bsr-discord").click(function () {
    window.invokeNative("openUrl", bsr_config.discord);
  });

  window.addEventListener("keydown", (event) => {
    if ( event.keyCode == 27 || event.keyCode == 8 ) {
      $.post("https://" + bsr_resource + "/hide");
    }
  })