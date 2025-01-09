// tailwind.config.js
/** @type {import('tailwindcss').Config} */
export default {
  content: ["./index.html", "./src/**/*.{js,ts,jsx,tsx}"],
  theme: {
    container: {
      center: true,
    },
    extend: {
      fontFamily: {
        custom: ["Montserrat", "sans-serif"], // Replace 'YourFontName' with the actual font name
      },
      fontWeight: {
        customfontweight: ["600"],
      },
      borderRadius: {
        'px-10': '10px',
        'px-20': '20px',
        'px-30': '30px',
      },
      fontSize: {
        h1: ["5rem", "auto"],
        h1mobile: ["3rem", "auto"],
      },
      transform: ["hover", "focus"], // Enable hover/focus transformation
      rotate: {
        360: "360deg",
        90: "90deg",
      },
      keyframes: {
        flip: {
          "0%": { transform: "rotateY(0deg)" },
          "100%": { transform: "rotateY(180deg)" },
        },
      },
      animation: {
        flip: "flip 1s ease-in-out infinite",
      },
    },
  },
  plugins: [],
};
