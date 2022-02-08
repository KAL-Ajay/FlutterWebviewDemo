import { Component, NgZone } from '@angular/core';
import { GlobalsService } from './globals.service';

declare function showSomethingOnFlutter(message: any): any;

@Component({
  selector: 'app-root',
  templateUrl: './app.component.html',
  styleUrls: ['./app.component.scss']
})
export class AppComponent {
  title = 'dwbAngularDemo';
  message: string = "";

  constructor(
    private zone: NgZone,
    private globals: GlobalsService
  ) {
    (window as any)["angularComponentRef"] = {
      zone: this.zone,
      displaySomething: (message: any) => this.displaySomething(message)
    };

  }
  displaySomething(message: any) {
    this.message = message;
    console.log(message);
  }

  showOnFlutter() {
    showSomethingOnFlutter("Angular app is saying hi to flutter");
  }
}
