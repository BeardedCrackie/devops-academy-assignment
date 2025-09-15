console.log("Starting app...");
setTimeout(() => {
throw new Error("App crashed on purpose!");
}, 1000);