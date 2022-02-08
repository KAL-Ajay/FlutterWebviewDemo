import { Injectable } from '@angular/core';
import { BehaviorSubject } from 'rxjs';

@Injectable({
  providedIn: 'root'
})
export class GlobalsService {

  constructor() { }

  messageSubscription: BehaviorSubject<string> = new BehaviorSubject<string>("");
}
