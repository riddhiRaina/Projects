//import {createStore} from 'redux';

const redux = require('redux');
const createStore = redux.createStore;

console.log("redux-demo");

//initial data that will reside inside the store
const initState = {
    count: 5,
    msg: 'hello'
}

//define Reducer -> to modify the store
//reducer can receive different actions in terms of if else or switch.
const reducer = (currentState=initState, action) => {
    console.log("action received: ", action);
    // inside reducer, once action is received we need to update the state
    if(action.type === "INC_CTR"){
        //state cannot be directly changed as its immutable
        return{
            //create new object/ copy of current state
            ... currentState,
            count: currentState.count + 1
        }
    }

    if(action.type === "DECR_CTR"){
        return{
            ... currentState,
            count: currentState.count - 1
        }
    }

    if(action.type === "UPD_CTR"){
        return{
            ... currentState,
            count: action.value
        }
    }
    //return the updated state
    return currentState;
}

//create the store
const store = createStore(reducer); //createstore is depricated
console.log("state: ", store.getState()); //store.getState() gives the current state.

//subscribe
//call whenever the state changes
store.subscribe(() => {
    console.log("state in subscriber:", store.getState());
})

//dispatch an action
store.dispatch({type: "INC_CTR"});
console.log("state: ", store.getState());

store.dispatch({type: "UPD_CTR", value: 100});
console.log("state: ", store.getState());

store.dispatch({type: "DECR_CTR"});
console.log("state: ", store.getState());


//execution can be done using browser/ NodeJs