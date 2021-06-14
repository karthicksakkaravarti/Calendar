import Vue from 'vue'
import Vuex from 'vuex'

Vue.use(Vuex)

export default new Vuex.Store({
  state: {
    Date: '2021-06-14'
  },
  getters:{
    GetDate : (state) => state.Date,
  },
  mutations: {
    MutationSetDate(state, data){
      state.Date = data
  }
  },
  actions: {
    setDate({commit}, value){
      commit('MutationSetDate',  value );
    },
  },
  modules: {
  }
})
