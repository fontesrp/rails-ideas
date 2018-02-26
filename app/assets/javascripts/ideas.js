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
    };

    window.addEventListener("load", winOnload);
}());
