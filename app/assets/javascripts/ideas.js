(function () {

    "use strict";

    const winOnload = function () {

        document.querySelectorAll(".click-icon").forEach(function (div) {

            div.addEventListener("click", function () {

                const icn = div.firstChild;
                const body = div.parentElement.nextElementSibling;

                if (icn.classList.contains("fa-plus")) {
                    icn.classList.remove("fa-plus");
                    icn.classList.add("fa-minus");
                    body.classList.remove("hidden");
                } else {
                    icn.classList.remove("fa-minus");
                    icn.classList.add("fa-plus");
                    body.classList.add("hidden");
                }
            });
        });

        const form = document.getElementById("new_idea");

        document.getElementById("new-idea-save").addEventListener("click", function () {
            form.submit();
        });
    };

    window.addEventListener("load", winOnload);
}());
