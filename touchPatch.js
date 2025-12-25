function createEvent(event, type, button) {
    let touches = event.changedTouches,
        first = touches[0];
    return new MouseEvent(type, {
        bubbles: true,
        cancelable: true,
        view: window,
        detail: 1,
        screenX: first.screenX,
        screenY: first.screenY,
        clientX: first.clientX,
        clientY: first.clientY,
        ctrlKey: false,
        altKey: false,
        shiftKey: false,
        metaKey: false,
        button: button || 0,
        relatedTarget: null
    });
}

let delay_time = 16;
let lastY = null;

document.addEventListener("touchstart", (event) => {
    if (event.touches.length === 3) {
        const touch1 = event.touches[0];
        const touch2 = event.touches[1];
        const touch3 = event.touches[2];
        setTimeout(() => {
            event.changedTouches[0].target.dispatchEvent(createEvent(event, "mousedown", 2));
        }, delay_time);
        setTimeout(() => {
            event.changedTouches[0].target.dispatchEvent(createEvent(event, "mouseup", 2));
        }, delay_time * 2);
    }
    
    if (event.touches.length === 2) {
        const touch1 = event.touches[0];
        const touch2 = event.touches[1];
        lastY = (touch1.clientY + touch2.clientY) / 2;
    }

    event.changedTouches[0].target.dispatchEvent(createEvent(event, "mousemove"));
    setTimeout(() => {
        event.changedTouches[0].target.dispatchEvent(createEvent(event, "mousedown"));
    }, delay_time);
    event.preventDefault();
    event.stopPropagation();
}, true);
document.addEventListener("touchmove", (event) => {

    if (event.touches.length === 2) {
        const touch1 = event.touches[0];
        const touch2 = event.touches[1];
        const currentY = (touch1.clientY + touch2.clientY) / 2;

        if (lastY !== null) {
            const deltaY = currentY - lastY;
            const wheelDelta = deltaY * -3;

            const wheelEvent = new WheelEvent('wheel', {
                deltaY: wheelDelta,
                deltaMode: 0,
                bubbles: true,
                screenX: (touch1.screenX + touch2.screenX) / 2,
                screenY: (touch1.screenY + touch2.screenY) / 2,
                clientX: (touch1.clientX + touch2.clientX) / 2,
                clientY: currentY,
                relatedTarget: null
            });
            document.getElementById("GameCanvas").dispatchEvent(wheelEvent);
        }
        lastY = currentY;
    }

    setTimeout(() => {
        event.changedTouches[0].target.dispatchEvent(createEvent(event, "mousemove"));
    }, delay_time);
    event.preventDefault();
    event.stopPropagation();
}, true);
document.addEventListener("touchend", (event) => {
    lastY = null;

    setTimeout(() => {
        event.changedTouches[0].target.dispatchEvent(createEvent(event, "mouseup"));
    }, delay_time);
    event.preventDefault();
    event.stopPropagation();
}, true);