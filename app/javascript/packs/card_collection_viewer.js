import Vue from 'vue/dist/vue.esm.js';
import TurbolinksAdapter from 'vue-turbolinks';

Vue.use(TurbolinksAdapter);

const template = document.getElementById("viewer__template").innerHTML;

new Vue({
    el: "#viewer__container",
    template: template,
    data: () => ({
        loaded: false,
        cards: [],
        current: 0,
        revealed: false,
    }),
    computed: {
        card: function () {
            if (this.loaded) return this.cards[this.current]
            else return {
                title: "Loading...",
                question: "",
                answer: ""
            }
        },
    },
    mounted: async function () {
        this.cards = await fetch(window.__cards_url).then(response => response.json());
        this.loaded = true;
        this._renderLatex();
    },
    methods: {
        toggleReveal: function () {
            this.revealed = !this.revealed;
            this._renderLatex();
        },
        nextCard: function () {
            this.current = (this.current + 1) % this.cards.length;
            this.revealed = false;
            this._renderLatex();
        },
        previousCard: function () {
            this.current--;
            if (this.current < 0) {
                this.current = (this.cards.length - 1);
            }

            this.revealed = false;

            this._renderLatex();
        },
        _renderLatex: function () {
            if (typeof window.MathJax !== 'undefined') {
                // Remove all previous renders
                Array.from(document.getElementsByClassName("MathJax")).forEach(element => element.remove());
                setTimeout(window.MathJax.typeset, 50);
            }
        }
    }
})
;