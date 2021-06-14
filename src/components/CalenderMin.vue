<template>
  <v-row class="ma-2">
    <v-date-picker header-color="primary" flat v-model="DateMount"></v-date-picker>
  </v-row>
</template>

<script>
export default {
    computed:{
     DateMount: {
            get(){
              return this.$store.state.Date
            },
            set(newName){
              // return this.ActionTotalRequest(newName)
              return this.$store.dispatch("setDate",newName);
            } 
         },
  },
  data() {
    return {
      picker: new Date().toISOString().substr(0, 10),
    };
  },
  methods: {
    setTodayDate(set_or_display) {
      var today = new Date();
      var dd = String(today.getDate()).padStart(2, "0");
      var mm = String(today.getMonth() + 1).padStart(2, "0"); //January is 0!
      var yyyy = today.getFullYear();
      if (set_or_display) {
        this.DateMount = yyyy + "-" + mm + "-" + dd;
      } else {
        return today.toDateString();
      }
    },
  },
};
</script>