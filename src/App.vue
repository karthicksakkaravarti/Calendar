<template>
  <v-app id="inspire">
    <v-app id="inspire">
      <v-navigation-drawer
        width="300"
        v-model="drawer"
        :clipped="$vuetify.breakpoint.lgAndUp"
        app
      >
        <v-list dense>
          <!-- Calendar Component -->
          <CalenderMin ref="CalenderMinRef" />

          <!-- Calendar Component Rnd -->
          <!-- <template v-for="item in items">
            <v-row
              v-if="item.heading"
              :key="item.heading"
              align="center"
            >
              <v-col cols="6">
                <v-subheader v-if="item.heading">
                  {{ item.heading }}
                </v-subheader>
              </v-col>
              <v-col
                cols="6"
                class="text-center"
              >
                <a
                  href="#!"
                  class="body-2 black--text"
                >EDIT</a>
              </v-col>
            </v-row>
            <v-list-group
              v-else-if="item.children"
              :key="item.text"
              v-model="item.model"
              :prepend-icon="item.model ? item.icon : item['icon-alt']"
              append-icon=""
            >
              <template v-slot:activator>
                <v-list-item-content>
                  <v-list-item-title>
                    {{ item.text }}
                  </v-list-item-title>
                </v-list-item-content>
              </template>
              <v-list-item
                v-for="(child, i) in item.children"
                :key="i"
                link
              >
                <v-list-item-action v-if="child.icon">
                  <v-icon>{{ child.icon }}</v-icon>
                </v-list-item-action>
                <v-list-item-content>
                  <v-list-item-title>
                    {{ child.text }}
                  </v-list-item-title>
                </v-list-item-content>
              </v-list-item>
            </v-list-group>
            <v-list-item
              v-else
              :key="item.text"
              link
            >
              <v-list-item-action>
                <v-icon>{{ item.icon }}</v-icon>
              </v-list-item-action>
              <v-list-item-content>
                <v-list-item-title>
                  {{ item.text }}
                </v-list-item-title>
              </v-list-item-content>
            </v-list-item>
          </template> -->
        </v-list>
      </v-navigation-drawer>

      <v-app-bar
        elevation="0"
        :clipped-left="$vuetify.breakpoint.lgAndUp"
        app
        color="white"
        outlined
      >
        <v-app-bar-nav-icon
          style="color: #5f6368"
          @click.stop="drawer = !drawer"
        ></v-app-bar-nav-icon>
        <v-toolbar-title style="width: 170px" class="ml-0 pl-4">
          <span color="primary">Calendar</span>
        </v-toolbar-title>
        <v-tooltip v-if="$refs.CalenderMinRef" bottom>
          <template v-slot:activator="{ on, attrs }">
            <!-- <span v-bind="attrs" v-on="on">This text has a tooltip</span> -->
            <v-btn
              v-bind="attrs"
              v-on="on"
              class="mr-2"
              @click="$refs.CalenderMinRef.setTodayDate(true)"
              small
              outlined
              >Today</v-btn
            >
          </template>
          <span>{{ $refs.CalenderMinRef.setTodayDate(false) }}</span>
        </v-tooltip>
        <v-btn icon class="ma-2" @click="$refs.CalenderMaxRef.prev()">
          <v-icon>mdi-chevron-left</v-icon>
        </v-btn>
        <v-btn icon class="ma-2" @click="$refs.CalenderMaxRef.next()">
          <v-icon>mdi-chevron-right</v-icon>
        </v-btn>
        <b v-if="$refs.CalenderMaxRef">{{
          $refs.CalenderMaxRef.GetMonthName()
        }}</b>

        <!-- <v-text-field
          flat
          solo-inverted
          hide-details
          prepend-inner-icon="mdi-magnify"
          label="Search"
          class="hidden-sm-and-down ml-10"
        ></v-text-field> -->
        <v-spacer></v-spacer>
        <v-menu small  v-if="$refs.CalenderMaxRef" bottom right>
          <template v-slot:activator="{ on, attrs }">
            <v-btn outlined color="grey darken-2" v-bind="attrs" v-on="on">
              <span>{{ typeToLabel[$refs.CalenderMaxRef.type] }}</span>
              <v-icon right>mdi-menu-down</v-icon>
            </v-btn>
          </template>
          <v-list dense>
            <v-list-item @click="$refs.CalenderMaxRef.type = 'day'">
              <v-list-item-title>Day</v-list-item-title>
            </v-list-item>
            <v-list-item @click="$refs.CalenderMaxRef.type = 'week'">
              <v-list-item-title>Week</v-list-item-title>
            </v-list-item>
            <v-list-item @click="$refs.CalenderMaxRef.type = 'month'">
              <v-list-item-title>Month</v-list-item-title>
            </v-list-item>
            <v-list-item @click="$refs.CalenderMaxRef.type = '4day'">
              <v-list-item-title>4 days</v-list-item-title>
            </v-list-item>
          </v-list>
        </v-menu>
        <!-- <v-btn icon>
          <v-icon>mdi-bell</v-icon>
        </v-btn> -->
        <v-btn icon large>
          <v-avatar size="32px" item>
            <v-img
              src="https://cdn.vuetifyjs.com/images/logos/logo.svg"
              alt="Vuetify"
            ></v-img
          ></v-avatar>
        </v-btn>
      </v-app-bar>
      <v-main>
        <CalenderMax ref="CalenderMaxRef" />
      </v-main>
    </v-app>
  </v-app>
</template>

<script>
import CalenderMin from "./components/CalenderMin.vue";
import CalenderMax from "./components/CalenderMax.vue";
export default {
  name: "App",
  components: { CalenderMin, CalenderMax },
  computed: {
    DateMount: {
      get() {
        return this.$store.state.Date;
      },
      set(newName) {
        // return this.ActionTotalRequest(newName)
        return this.$store.dispatch("setDate", newName);
      },
    },
  },
  data: () => ({
    dialog: false,
    drawer: null,
    typeToLabel: {
      month: "Month",
      week: "Week",
      day: "Day",
      "4day": "4 Days",
    },
    items: [
      { icon: "mdi-contacts", text: "Contacts" },
      { icon: "mdi-history", text: "Frequently contacted" },
      { icon: "mdi-content-copy", text: "Duplicates" },
      {
        icon: "mdi-chevron-up",
        "icon-alt": "mdi-chevron-down",
        text: "Labels",
        model: true,
        children: [{ icon: "mdi-plus", text: "Create label" }],
      },
      {
        icon: "mdi-chevron-up",
        "icon-alt": "mdi-chevron-down",
        text: "More",
        model: false,
        children: [
          { text: "Import" },
          { text: "Export" },
          { text: "Print" },
          { text: "Undo changes" },
          { text: "Other contacts" },
        ],
      },
      { icon: "mdi-cog", text: "Settings" },
      { icon: "mdi-message", text: "Send feedback" },
      { icon: "mdi-help-circle", text: "Help" },
      { icon: "mdi-cellphone-link", text: "App downloads" },
      { icon: "mdi-keyboard", text: "Go to the old version" },
    ],
  }),
};
</script>


